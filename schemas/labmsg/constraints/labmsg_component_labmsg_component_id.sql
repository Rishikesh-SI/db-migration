-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_component labmsg_component_id
-- Type: CONSTRAINT

-- Name: labmsg_component labmsg_component_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_component
    ADD CONSTRAINT labmsg_component_id PRIMARY KEY (component_id);


--
