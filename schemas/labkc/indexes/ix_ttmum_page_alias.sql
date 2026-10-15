-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labkc; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labkc.labkc_page USING btree (alias);


--
