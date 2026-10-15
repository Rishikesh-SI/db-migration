-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_component scom_component_id
-- Type: CONSTRAINT

-- Name: scom_component scom_component_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_component
    ADD CONSTRAINT scom_component_id PRIMARY KEY (component_id);


--
