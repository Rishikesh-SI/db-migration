-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: article_upd_2016_published_date_idx
-- Type: INDEX

-- Name: article_upd_2016_published_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX article_upd_2016_published_date_idx ON public.article_upd_2016 USING btree (published_date DESC);


--
