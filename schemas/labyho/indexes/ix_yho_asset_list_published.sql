-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: ix_yho_asset_list_published
-- Type: INDEX

-- Name: ix_yho_asset_list_published; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX ix_yho_asset_list_published ON labyho.labyho_asset_list USING btree (is_published, is_active, is_deleted);


--
