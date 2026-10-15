-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: molecule_atom_map fk_atom
-- Type: FK CONSTRAINT

-- Name: molecule_atom_map fk_atom; Type: FK CONSTRAINT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.molecule_atom_map
    ADD CONSTRAINT fk_atom FOREIGN KEY (atom_json_id) REFERENCES lb_wf.atoms(json_id) ON DELETE CASCADE;


--
