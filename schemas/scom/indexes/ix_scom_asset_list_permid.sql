-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_asset_list_permid
-- Type: INDEX

-- Name: ix_scom_asset_list_permid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_asset_list_permid ON scom.scom_asset_list USING btree (primary_entity_role_map_id);


--
