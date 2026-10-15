-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labyho.labyho_page USING btree (alias);


--
