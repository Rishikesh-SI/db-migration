-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labtkr; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labtkr.labtkr_page USING btree (alias);


--
