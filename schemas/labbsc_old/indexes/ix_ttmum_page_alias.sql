-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labbsc_old; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labbsc_old.labbsc_page USING btree (alias);


--
