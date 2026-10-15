-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_page_alias
-- Type: INDEX

-- Name: ix_rfg_page_alias; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_page_alias ON rfg.rfg_page USING btree (alias);


--
