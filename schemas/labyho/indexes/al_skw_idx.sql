-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: al_skw_idx
-- Type: INDEX

-- Name: al_skw_idx; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX al_skw_idx ON labyho.labyho_asset_list USING gin (tvs);


--
