-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_asset_type_meta labmsg_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labmsg_asset_type_meta labmsg_asset_type_meta_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_asset_type_meta
    ADD CONSTRAINT labmsg_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
