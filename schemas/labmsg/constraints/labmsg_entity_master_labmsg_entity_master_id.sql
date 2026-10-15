-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_entity_master labmsg_entity_master_id
-- Type: CONSTRAINT

-- Name: labmsg_entity_master labmsg_entity_master_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_entity_master
    ADD CONSTRAINT labmsg_entity_master_id PRIMARY KEY (entity_master_id);


--
