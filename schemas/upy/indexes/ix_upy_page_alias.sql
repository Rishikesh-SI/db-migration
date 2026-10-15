-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_page_alias
-- Type: INDEX

-- Name: ix_upy_page_alias; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_page_alias ON upy.upy_page USING btree (alias);


--
