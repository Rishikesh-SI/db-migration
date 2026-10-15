-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labbsc; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labbsc.labbsc_page USING btree (alias);


--
