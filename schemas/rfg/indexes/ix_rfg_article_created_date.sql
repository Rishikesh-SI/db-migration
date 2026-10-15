-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_article_created_date
-- Type: INDEX

-- Name: ix_rfg_article_created_date; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_article_created_date ON rfg.rfg_article USING btree (created_date);


--
