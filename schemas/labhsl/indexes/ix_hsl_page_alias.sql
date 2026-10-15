-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_page_alias
-- Type: INDEX

-- Name: ix_hsl_page_alias; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_page_alias ON labhsl.labhsl_page USING btree (alias);


--
