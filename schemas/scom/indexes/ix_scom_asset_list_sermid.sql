-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_asset_list_sermid
-- Type: INDEX

-- Name: ix_scom_asset_list_sermid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_asset_list_sermid ON scom.scom_asset_list USING btree (secondary_entity_role_map_id);


--
