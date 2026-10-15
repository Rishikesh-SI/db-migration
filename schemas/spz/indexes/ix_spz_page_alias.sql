-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_page_alias
-- Type: INDEX

-- Name: ix_spz_page_alias; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_page_alias ON spz.spz_page USING btree (alias);


--
