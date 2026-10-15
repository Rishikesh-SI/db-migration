-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: uar_raaurp_idx
-- Type: INDEX

-- Name: uar_raaurp_idx; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX uar_raaurp_idx ON dhm.dhm_user_asset_reaction USING btree (asset_id, asset_type_id, user_id, reaction_id);


--
