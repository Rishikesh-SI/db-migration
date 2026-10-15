-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_asset_list_sermid
-- Type: INDEX

-- Name: ix_tfa_asset_list_sermid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_asset_list_sermid ON tfa.tfa_asset_list USING btree (secondary_entity_role_map_id);


--
