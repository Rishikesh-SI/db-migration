-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: atoms atoms_json_id_unique
-- Type: CONSTRAINT

-- Name: atoms atoms_json_id_unique; Type: CONSTRAINT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.atoms
    ADD CONSTRAINT atoms_json_id_unique UNIQUE (json_id);


--
