-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labrr.labrr_page USING btree (alias);


--
