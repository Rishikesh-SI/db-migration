-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: uar_aatr_idx
-- Type: INDEX

-- Name: uar_aatr_idx; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX uar_aatr_idx ON labyho.labyho_user_asset_reaction USING btree (asset_id, asset_type_id, reaction_id);


--
