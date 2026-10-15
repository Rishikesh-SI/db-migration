-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_asset_combine_idx
-- Type: INDEX

-- Name: labkc_v1_asset_combine_idx; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX labkc_v1_asset_combine_idx ON labkc_v1.labkc_v1_asset_draft USING btree (asset_id, asset_type_id, version_number);


--
