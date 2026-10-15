-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_asset_delete_log lablsg_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: lablsg_asset_delete_log lablsg_asset_delete_log_id; Type: CONSTRAINT; Schema: lablsg; Owner: -
--

ALTER TABLE ONLY lablsg.lablsg_asset_delete_log
    ADD CONSTRAINT lablsg_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
