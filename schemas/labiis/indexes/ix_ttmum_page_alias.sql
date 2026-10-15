-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labiis; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labiis.labiis_page USING btree (alias);


--
