-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labsrk; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labsrk.labsrk_page USING btree (alias);


--
