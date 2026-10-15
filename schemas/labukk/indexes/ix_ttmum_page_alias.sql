-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labukk; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labukk.labukk_page USING btree (alias);


--
