-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labdsg; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labdsg.labdsg_page USING btree (alias);


--
