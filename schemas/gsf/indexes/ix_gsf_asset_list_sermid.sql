-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_asset_list_sermid
-- Type: INDEX

-- Name: ix_gsf_asset_list_sermid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_asset_list_sermid ON gsf.gsf_asset_list USING btree (secondary_entity_role_map_id);


--
