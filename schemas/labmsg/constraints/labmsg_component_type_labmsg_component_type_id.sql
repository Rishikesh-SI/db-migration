-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_component_type labmsg_component_type_id
-- Type: CONSTRAINT

-- Name: labmsg_component_type labmsg_component_type_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_component_type
    ADD CONSTRAINT labmsg_component_type_id PRIMARY KEY (component_type_id);


--
