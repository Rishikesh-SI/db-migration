-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: acr_aac_idx
-- Type: INDEX

-- Name: acr_aac_idx; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX acr_aac_idx ON labmi_beta_22042024.labmi_asset_comment_reaction USING btree (asset_id, asset_type_id, comment_id);


--
