-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: acr_aac_idx
-- Type: INDEX

-- Name: acr_aac_idx; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX acr_aac_idx ON dhm.dhm_asset_comment_reaction USING btree (asset_id, asset_type_id, comment_id);


--
