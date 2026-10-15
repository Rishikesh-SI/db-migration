-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labdms.labdms_page USING btree (alias);


--
