-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labmsg_contact scom_contact_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
