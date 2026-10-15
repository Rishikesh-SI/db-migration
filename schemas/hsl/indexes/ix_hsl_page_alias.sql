-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_page_alias
-- Type: INDEX

-- Name: ix_hsl_page_alias; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_page_alias ON hsl.hsl_page USING btree (alias);


--
