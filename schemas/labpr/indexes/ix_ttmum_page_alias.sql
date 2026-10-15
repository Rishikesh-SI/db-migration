-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labpr; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labpr.labpr_page USING btree (alias);


--
