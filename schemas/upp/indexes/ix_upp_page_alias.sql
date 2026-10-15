-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_page_alias
-- Type: INDEX

-- Name: ix_upp_page_alias; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_page_alias ON upp.upp_page USING btree (alias);


--
