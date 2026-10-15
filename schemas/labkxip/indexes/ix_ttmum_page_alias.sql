-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labkxip.labkxip_page USING btree (alias);


--
