-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: ix_ttmum_asset_list_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_atid; Type: INDEX; Schema: labiis; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_atid ON labiis.labiis_asset_list USING btree (asset_type_id);


--
