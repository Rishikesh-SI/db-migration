-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_asset_list_atid
-- Type: INDEX

-- Name: ix_cfc_asset_list_atid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_asset_list_atid ON cfc.cfc_asset_list USING btree (asset_type_id);


--
