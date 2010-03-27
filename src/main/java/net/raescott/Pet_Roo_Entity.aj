package net.raescott;

import java.lang.Integer;
import java.lang.Long;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PersistenceContext;
import javax.persistence.Version;
import net.raescott.Pet;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Pet_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager Pet.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Pet.id;
    
    @Version
    @Column(name = "version")
    private Integer Pet.version;
    
    public Long Pet.getId() {
        return this.id;
    }
    
    public void Pet.setId(Long id) {
        this.id = id;
    }
    
    public Integer Pet.getVersion() {
        return this.version;
    }
    
    public void Pet.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void Pet.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Pet.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Pet attached = this.entityManager.find(Pet.class, this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Pet.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Pet.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Pet merged = this.entityManager.merge(this);
        this.entityManager.flush();
        this.id = merged.getId();
    }
    
    public static final EntityManager Pet.entityManager() {
        EntityManager em = new Pet().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Pet.countPets() {
        return (Long) entityManager().createQuery("select count(o) from Pet o").getSingleResult();
    }
    
    public static List<Pet> Pet.findAllPets() {
        return entityManager().createQuery("select o from Pet o").getResultList();
    }
    
    public static Pet Pet.findPet(Long id) {
        if (id == null) return null;
        return entityManager().find(Pet.class, id);
    }
    
    public static List<Pet> Pet.findPetEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from Pet o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
