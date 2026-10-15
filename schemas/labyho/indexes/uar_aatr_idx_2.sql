-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: uar_aatr_idx_2
-- Type: INDEX

-- Name: uar_aatr_idx_2; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX uar_aatr_idx_2 ON labyho.labyho_user_asset_reaction_dk USING btree (asset_id DESC NULLS LAST, asset_type_id DESC NULLS LAST);


--
