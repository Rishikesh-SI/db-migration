-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_page_alias_idx
-- Type: INDEX

-- Name: lablsg_page_alias_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_page_alias_idx ON fanxp_lsg.lablsg_page USING btree (alias);


--
