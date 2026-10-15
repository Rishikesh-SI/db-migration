-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_component tfa_component_id
-- Type: CONSTRAINT

-- Name: tfa_component tfa_component_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_component
    ADD CONSTRAINT tfa_component_id PRIMARY KEY (component_id);


--
