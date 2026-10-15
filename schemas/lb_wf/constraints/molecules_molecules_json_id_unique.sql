-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: molecules molecules_json_id_unique
-- Type: CONSTRAINT

-- Name: molecules molecules_json_id_unique; Type: CONSTRAINT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.molecules
    ADD CONSTRAINT molecules_json_id_unique UNIQUE (json_id);


--
