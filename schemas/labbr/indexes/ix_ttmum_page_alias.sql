-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labbr; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labbr.labbr_page USING btree (alias);


--
