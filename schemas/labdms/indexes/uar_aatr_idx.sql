-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: uar_aatr_idx
-- Type: INDEX

-- Name: uar_aatr_idx; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX uar_aatr_idx ON labdms.labdms_user_asset_reaction USING btree (asset_id, asset_type_id, reaction_id);


--
