-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: acr_aac_idx
-- Type: INDEX

-- Name: acr_aac_idx; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX acr_aac_idx ON isl.isl_asset_comment_reaction USING btree (asset_id, asset_type_id, comment_id);


--
