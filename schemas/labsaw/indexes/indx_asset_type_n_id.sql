-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: indx_asset_type_n_id
-- Type: INDEX

-- Name: indx_asset_type_n_id; Type: INDEX; Schema: labsaw; Owner: -
--

CREATE UNIQUE INDEX indx_asset_type_n_id ON labsaw.labsaw_seo_data USING btree (asset_id, asset_type_id);


--
