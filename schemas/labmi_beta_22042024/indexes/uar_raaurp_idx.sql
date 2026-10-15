-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: uar_raaurp_idx
-- Type: INDEX

-- Name: uar_raaurp_idx; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX uar_raaurp_idx ON labmi_beta_22042024.labmi_user_asset_reaction USING btree (asset_id, asset_type_id, user_id, reaction_id);


--
