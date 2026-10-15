-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: uar_raaurp_idx
-- Type: INDEX

-- Name: uar_raaurp_idx; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX uar_raaurp_idx ON labmi_v1.labmi_v1_user_asset_reaction USING btree (asset_id, asset_type_id, user_id, reaction_id);


--
