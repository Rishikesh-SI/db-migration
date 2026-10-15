-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_asset_group labmsg_asset_group_id
-- Type: CONSTRAINT

-- Name: labmsg_asset_group labmsg_asset_group_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_asset_group
    ADD CONSTRAINT labmsg_asset_group_id PRIMARY KEY (asset_group_id);


--
