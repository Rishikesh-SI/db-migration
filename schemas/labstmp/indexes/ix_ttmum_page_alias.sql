-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labstmp.labstmp_page USING btree (alias);


--
